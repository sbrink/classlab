defmodule Classlab.Superadmin.DashboardController do
  use Classlab.Web, :controller

  def show(conn, _params) do
    render conn, "show.html"
  end
end
