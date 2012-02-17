module Admin
  class HomeController < BaseController
    def index
      @names = %W{Slide Article ArticleImage Product ProductImage Category CategoryImage User}
      @counts = []
      begin
        @names.each do |name|
          @counts << name.constantize.count
        end
      rescue
      end
    end
  end
end

