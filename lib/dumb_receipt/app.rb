require 'sinatra/base'
require 'redcarpet'
require 'slim'
require 'sass'
require 'coffee-script'

require 'dumb_receipt/handlers/images'
require 'dumb_receipt/handlers/offers'
require 'dumb_receipt/handlers/receipts'
require 'dumb_receipt/handlers/registration'
require 'dumb_receipt/handlers/stats'
require 'dumb_receipt/handlers/sync'

module DumbReceipt
  class App < Sinatra::Base

    # the implicit setting isn't working with rackup
    set :public_folder, 'public'
    set :root, File.expand_path('../../..', __FILE__)

    get('/')                { markdown :README, layout_engine: :slim }
    get('/application.css') { sass     :application }
    get('/application.js')  { coffee   :application }

    ##
    # Most of the work of the app is handled by these middleware classes.
    #
    use DumbReceipt::Handlers::Images
    use DumbReceipt::Handlers::Offers
    use DumbReceipt::Handlers::Receipts
    use DumbReceipt::Handlers::Registration
    use DumbReceipt::Handlers::Stats
    use DumbReceipt::Handlers::Sync
  end
end
