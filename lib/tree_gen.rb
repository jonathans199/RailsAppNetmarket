module TreeGen
  # json tree with level of depth indicated
  class Unilevel
    def initialize(depth)  
      @depth = depth
      @array = []
    end

    def total(user)
      iterate(auto_gen(user,0))
      @array = @array.map { |x| total_purchases(x) }.compact.reduce(0,:+)
      return @array
    end

    def iterate(user)
      user[:children].map { |x| 
        @array << x[:name]
        iterate(x) if x[:children]
      }
    end

    def tree(user)
      return auto_gen(user,0)
    end

    def auto_gen(user, n)
      n += 1
      result = User.where(parent_uuid: user.uuid).each_with_index.map { |x,i| auto_gen(x,n) if n <= @depth }.compact
      result = nil if n > @depth
      {
        name: user.username,
        children: result
      }
    end      

    def total_purchases(username)
      user  =  User.find_by(username:username)
      total_spent = user.invoices.where(invoice_status_id:12).map { |x| x.plan.price }
      return total_spent.reduce(0,:+)
    end
  end

end
