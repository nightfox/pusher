# Global cors configuration
require 'sinatra/cross_origin'

set :allow_origin, :any
set :allow_methods, [:get, :post, :options]
set :allow_credentials, true
set :max_age, '1728000'
set :expose_headers, ['Content-Type']

post '/document' do
  cross_origin

  document = ::FirebaseReplica.where(id: params[:path][0]).first_or_initialize
  remaining_path = params[:path][1..-1] + ['history', params['revision_id']]

  root = document['data'] || {}
  remaining_path.each do |_path|
    root[_path] ||= {}
    root = root[_path]
  end

  root['a'] = params['uid']
  root['o'] = params['op']
  root['t'] = Time.now.to_i

  document.save
end

post '/settings' do
  cross_origin

  document = ::FirebaseReplica.where(id: params[:path][0]).first_or_initialize
  remaining_path = params[:path][1..-1] + ['history', params['revision_id']]

end

post '/tracker' do
  cross_origin

  binding.pry
end

options '*' do
  response.headers['Allow'] = 'HEAD,GET,PUT,POST,DELETE,OPTIONS'

  response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'

  200
end