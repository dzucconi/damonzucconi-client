# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :sidebar

  caches_action :sidebar, expires_in: 24.hours

  class QueryExecutionError < StandardError; end

  unless Rails.application.config.consider_all_requests_local
    rescue_from QueryExecutionError, with: :not_found
    rescue_from ActionController::RoutingError, with: :not_found
  end

  private

  def not_found(message = '')
    current_path = url_for(request.params)
    paths = @sidebar.artworks.concat(@sidebar.exhibitions).map(&:path)
    @nearest = Nearest::Finder.new(current_path, paths)
    @message = message

    render 'errors/not_found', status: :not_found
  end

  def query(q, variables = {}, *attributes)
    res = DamonZucconiAPI::Client.query(q, variables: variables)

    if res.errors.any?
      raise QueryExecutionError, res.errors.messages.values.flatten.join(', ')
    elsif res.data.errors.any?
      raise QueryExecutionError, res.data.errors.messages.values.flatten.join(', ')
    else
      res.data.values_at(*attributes)
    end
  end

  def sidebar
    artworks, exhibitions = query(SidebarQuery, {}, :artworks, :exhibitions)
    @sidebar = Sidebar::Links.new(artworks, exhibitions)
  end
end
