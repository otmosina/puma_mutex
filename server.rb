require 'sinatra'

class Cashe
    class << self
        def init_cache
            @cache ||= {}.tap do |hash|
                hash[:value] = "Just one value"
            end
        end
    end
end

@c = Cashe.init_cache
p @c

def make_response(value)
    return "Thread: #{Thread.current.object_id} #{value}"
end

get '/cache' do
    @c = Cashe.init_cache
    make_response @c.to_json
end
