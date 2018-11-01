json.extract! comment, :id, :name, :email, :content, :article_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
