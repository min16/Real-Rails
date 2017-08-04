require 'sinatra'
require 'yaml/store'

TIMES = {
  'FRI' => 'Friday Night',
  'THU' => 'Thursday Night',
  'WED' => 'Wednesday Night'
}

get '/' do
  erb :index
end

get '/vote' do
  @vote = TIMES[params[:vote]]
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :vote
end

get '/result' do
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction do
    @store['votes']
  end
  erb :result
end
