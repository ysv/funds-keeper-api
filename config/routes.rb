Rails.application.routes.draw do
  mount API::Base => API::Base::PATH
end
