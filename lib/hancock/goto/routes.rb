module ActionDispatch::Routing
  class Mapper

    def hancock_cms_goto_routes(no_params = false)
      if no_params.is_a?(Hash)
        no_params = (no_params[:no_params].present? ? no_params[:no_params] : true)
      end

      scope module: 'hancock' do
        scope module: 'goto' do
          if no_params
            get 'goto/*url' => 'transfers#index', as: :hancock_goto, format: false
          else
            get 'goto' => 'transfers#index', as: :hancock_goto, format: false
          end
        end
      end

    end

  end
end
