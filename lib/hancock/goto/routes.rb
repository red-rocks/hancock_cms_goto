module ActionDispatch::Routing
  class Mapper

    def hancock_cms_goto_routes

      scope module: 'hancock' do
        scope module: 'goto' do
          get '/goto/*url' => 'transfers#index', as: :hancock_goto, format: false
        end
      end

    end

  end
end
