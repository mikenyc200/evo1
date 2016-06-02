class Entry < ActiveRecord::Base
  belongs_to :feed
  has_many :keywords, dependent: :destroy
  has_many :concepts, dependent: :destroy
  has_many :entities, dependent: :destroy

  validates :atom_id, uniqueness: {scope: :feed_id}
  validates :url, uniqueness: true
  validates :title, uniqueness: true

  require './././alchemyapi_ruby/alchemyapi'


  default_scope {
    order('created_at DESC')
  }

  after_create :alchemy_extract


  def alchemy_extract

    alchemyapi = AlchemyAPI.new()

    ######## TITLE
    response = alchemyapi.title('url', url, { 'extractMode'=>'trust-metadata' })

    if response['status'] == 'OK'
    	if response.key?('title')
    		self.update(:title => response['title'])
    	end
    end


    ######## IMAGE EXTRACT



    response = alchemyapi.image_extract('url', url, { 'extractMode'=>'trust-metadata' })

    if response['status'] == 'OK'
    	if response.key?('image')
    		self.update(:image => response['image'])
    	end
    end

    ######### TRUMP SENTIMENT
    response = alchemyapi.sentiment_targeted('url', url, 'Trump')

    if response['status'] == 'OK'
    	if response['docSentiment'].key?('score')
    		self.update(:trump => response['docSentiment']['score'])
    	end
    end

    ######### CLINTON SENTIMENT
    response = alchemyapi.sentiment_targeted('url', url, 'Clinton')

    if response['status'] == 'OK'
      if response['docSentiment'].key?('score')
        self.update(:clinton => response['docSentiment']['score'])
      end
    end

    ######### TEXT CONTENT
    response = alchemyapi.text('url', url)

    if response['status'] == 'OK'
    	self.update(:content => response['text'])
    end

    ######### keywords
    #response = alchemyapi.keywords('url', url)

    #if response['status'] == 'OK'
    #	for keyword in response['keywords']
    #	    Keyword.create(:text => keyword['text'], :relevance => keyword['relevance'], :entry_id => self.id)
    #	end
    #end

    ######### ENTITIES
    #response = alchemyapi.entities('url', url)

    #if response['status'] == 'OK'
    #	for entity in response['entities']
    #	    Entity.create(:text => entity['text'], :relevance => entity['relevance'], :entry_id => self.id)
    #	end
    #end

    ######### CONCEPTS
    #response = alchemyapi.concepts('url', url)

    #if response['status'] == 'OK'
    #	for concept in response['concepts']
    #	    Concept.create(:text => concept['text'], :relevance => concept['relevance'], :entry_id => self.id)
    #	end
    #end


  end


end
