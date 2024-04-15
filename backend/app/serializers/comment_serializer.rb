# app/serializers/comment_serializer.rb
class CommentSerializer < ActiveModel::Serializer
    attributes :id, :body, :name
  end