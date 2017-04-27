defmodule Diskusi.PageController do
  use Diskusi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
