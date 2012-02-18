module Admin
  class PlistsController < BaseController
    actions :all, :except => :show
  end
end