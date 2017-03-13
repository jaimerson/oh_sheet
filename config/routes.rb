OhSheet::Engine.routes.draw do
  post '/import/:resource_name', to: 'importers#import', as: :importer
end
