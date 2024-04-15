module Api
  class FeaturesController < ApplicationController
    def index
      mag_types = params[:filters]&.dig(:mag_type)&.split(',') || []
      page = params[:page] || 1
      per_page = params[:per_page].to_i
      per_page = 100 if per_page > 100 || per_page <= 0

      features = Feature.all
      features = features.where(mag_type: mag_types) if mag_types.present?
      paginated_features = features.paginate(page: page, per_page: per_page)

      render json: {
        data: ActiveModel::SerializableResource.new(paginated_features, each_serializer: FeatureSerializer),
        pagination: {
          current_page: paginated_features.current_page,
          total: paginated_features.total_entries,
          per_page: paginated_features.per_page
        }
      }
    end

    # POST /api/features/:feature_id/comments
    skip_before_action :verify_authenticity_token, only: [:create_comment]
    def create_comment
      feature = Feature.find(params[:feature_id])
      comment = feature.comments.build(comment_params)

      if comment.save
        render json: comment, status: :created
      else
        render json: comment.errors, status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body, :name)
    end
  end
end