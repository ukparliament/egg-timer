Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    allowed_origins = ['api.parliament.uk']

    if Rails.configuration.asset_host.present?
      asset_host = Rails.configuration.asset_host.gsub(/^https?:\/\//, '')
      allowed_origins << asset_host
    end

    origins allowed_origins.uniq
    resource %r{/fonts/.*\.(woff|woff2|ttf|eot|otf)$},
            headers: :any,
            methods: [:get, :head, :options]
  end
end

