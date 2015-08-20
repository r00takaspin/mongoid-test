#
# Root class
#
class Article
	include Mongoid::Document

	field :article_title

	embeds_many :blocks, class_name: 'Article::Block', cascade_callbacks: true
	accepts_nested_attributes_for :blocks, allow_destroy: true  
	
	#
	# Class embedded via embeds_many  
	#
	class Block
		include Mongoid::Document
		
		field :block_title
		
		embedded_in :article, class_name: 'Article'	
		embeds_one :squib, class_name: 'Article::Block::Squib', cascade_callbacks: true
		accepts_nested_attributes_for :squib, allow_destroy: true
		
		#
		# Class embedded via embeds_one
		#
		class Squib
			include Mongoid::Document
			
			field :squib_title
			
			embedded_in :block,class_name: 'Article::Block'
		end

	end
end
