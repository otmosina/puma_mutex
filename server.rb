require 'sinatra'
require 'dry-initializer'

module Repository
    class Value
        def self.get
            rand(1000).to_s
        end
    end
end        
            
class Cashe
    
    #extend Dry::Initializer
    #option :repo, default: -> { Repository::Value }
    #@@cache = {}

    class << self
        def repo
            Repository::Value
        end

        def init_dog_cache(value = nil)
            @@cache ||= {}.tap do |hash|
                hash[:value] = "Random: #{repo.get}"
            end
        end
        
        def init_cache(value = nil)
            @cache ||= {}.tap do |hash|
                hash[:value] = "Random: #{repo.get}"
            end
        end
        def set_cache(value)
            @cache[:value] = value
        end
        
    end
end

def make_response(value)
    return "Process.pid #{Process.pid} Thread: #{Thread.current.object_id} #{value}"
end

get '/cache' do
    @c = Cashe.init_cache
    @c_dog = Cashe.init_dog_cache
    make_response [@c, @c_dog]
end

get '/cache/:value' do
    @c = Cashe.set_cache(params[:value])
    make_response @c.to_json + " new value #{params[:value]}"
end
