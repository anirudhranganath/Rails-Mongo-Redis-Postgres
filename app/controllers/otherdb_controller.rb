require 'mongo'
include Mongo

class OtherdbController < ApplicationController
  def index
    #@message = 'works'
    mongo_client = MongoClient.new("localhost", 27017).db("mydb")
    #@message = mongo_client.collection("testData").find_one
    #@message = mongo_client.collection("testData").find.each { |row| puts row.inspect }
    out = []
    mongo_client.collection("testData").find.each { |x| out.push(x)}
    @msgarr = out
    $redis = Redis.new(:host => 'localhost', :port => 6379)
    keys = $redis.keys('*')
    rarr = []
    keys.each {|k| rarr.push(k + '=>' + $redis.get(k))}
    @rmsgarr = rarr
  end
  def create
    render :nothing => true
  end
end
