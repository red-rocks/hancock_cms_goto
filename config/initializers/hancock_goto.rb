Hancock.rails_admin_configure do |config|
  if defined?(RailsAdminComments)
    config.action_visible_for :comments, 'Hancock::Goto::Transfer'
    config.action_visible_for :model_comments, 'Hancock::Goto::Transfer'
  end
end
