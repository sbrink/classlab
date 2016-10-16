defmodule Classlab.Account.DashboardControllerTest do
  use Classlab.ConnCase

  setup %{conn: conn} do
    user = Factory.insert(:user)
    {:ok, conn: Session.login(conn, user)}
  end

  describe "#show" do
    test "shows chosen resource", %{conn: conn} do
      conn = get conn, account_dashboard_path(conn, :show)
      assert html_response(conn, 200) =~ "Dashboard"
    end
  end
end
