require 'ruby-debug'
module Quaderno
  module Behavior
    module Crud         
      def self.included(receiver)
        receiver.send :extend, ClassMethods
      end
      
      module ClassMethods
        def to_instance(klass, hash)
          klass.new hash
        end
        
        def parse(element)
          payments_collection = []
          element['payments'].each do |payment|
            payments_collection << api_model.to_instance(Quaderno::Payment, payment)
          end unless api_model == Quaderno::Estimate
          element['payments'] = payments_collection
          
          items_collection = []
          element['items'].each do |item|
            items_collection << api_model.to_instance(Quaderno::Item, item)
          end
          element['items'] = items_collection
          
          contact = api_model.to_instance(Quaderno::Contact, element['contact'])
          element['contact'] = contact
        end
        
        def all
          party_response = get("/#{ api_model.subdomain }/api/v1/#{ api_model.api_path }.json", basic_auth: { username: api_model.auth_token })
          api_model.set_rate_limit_info(party_response.headers["x-ratelimit-limit"].to_i, party_response.headers["x-ratelimit-remaining"].to_i)
          array = JSON::parse party_response.body
          collection = []
          array.each do |element|  
            if (api_model == Quaderno::Invoice) || (api_model == Quaderno::Estimate) || (api_model == Quaderno::Expense)
              api_model.parse(element)
            end
            collection << (new element)
          end          
          collection
        end

        def find(id)
          party_response = get "/#{ api_model.subdomain }/api/v1/#{ api_model.api_path }/#{ id }.json", basic_auth: { username: api_model.auth_token }
          api_model.set_rate_limit_info(party_response.headers["x-ratelimit-limit"].to_i, party_response.headers["x-ratelimit-remaining"].to_i)
          hash = JSON::parse party_response.body
          if (api_model == Quaderno::Invoice) || (api_model == Quaderno::Estimate) || (api_model == Quaderno::Expense)
            api_model.parse(hash)
          end
          new hash
        end

        def create(params)
          party_response = post "/#{ api_model.subdomain }/api/v1/#{ api_model.api_path }.json", body: params, basic_auth: { username: api_model.auth_token }
          api_model.set_rate_limit_info(party_response.headers["x-ratelimit-limit"].to_i, party_response.headers["x-ratelimit-remaining"].to_i)
          hash = JSON::parse party_response.body
          if (api_model == Quaderno::Invoice) || (api_model == Quaderno::Estimate) || (api_model == Quaderno::Expense)
            api_model.parse(hash)
          end
          new hash
        end

        def update(id, params)
          party_response = put "/#{ api_model.subdomain }/api/v1/#{ api_model.api_path }/#{ id }.json", body: params, basic_auth: { username: api_model.auth_token }
          api_model.set_rate_limit_info(party_response.headers["x-ratelimit-limit"].to_i, party_response.headers["x-ratelimit-remaining"].to_i)
          hash = JSON::parse party_response.body
          debugger
          if (api_model == Quaderno::Invoice) || (api_model == Quaderno::Estimate) || (api_model == Quaderno::Expense)
            api_model.parse(hash)
          end
          new hash
        end

        def delete(id)
          party_response = HTTParty.delete "#{ api_model.base_uri }/#{ api_model.subdomain }/api/v1/#{ api_model.api_path }/#{ id }.json", basic_auth: { username: api_model.auth_token }
          api_model.set_rate_limit_info(party_response.headers["x-ratelimit-limit"].to_i, party_response.headers["x-ratelimit-remaining"].to_i)
        end
      end
    end
  end
end