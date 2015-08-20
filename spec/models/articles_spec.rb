require 'rails_helper'

describe Article,type: :model do
	it 'should be created and updated' do
		a = Article.new(article_title: 'Some article Title');
		a.blocks << Article::Block.new(block_title: 'Some block title')
		a.blocks.first.squib = Article::Block::Squib.new(squib_title: 'Some squib title')
		a.save!


		a.update_attributes({
			'_id'=>a.id.to_s,
		       	'article_title'=>'Some new article title',	
			'blocks_attributes'=>[
				{
					'_id'=>a.blocks.first.id.to_s,
					'block_title'=>'Some new block title',
					'squib_attributes'=>{
						'_id' => a.blocks.first.squib.id.to_s,
						'title' => 'Some new squib title',
						'_destroy'=>1
					}	
				}
			]
		})

		expect(a.blocks.first.squib.present?).not_to be_true
	end
end
