defmodule SutrauiDemoWeb.CSP do
  @moduledoc """
  The demo's strict Content-Security-Policy, with a per-request script nonce.

      script-src 'self' 'nonce-...'; style-src 'self'; img-src 'self' data:

  The plug assigns `conn.assigns.csp_nonce` and sends the header. A LiveView gets the same
  value as `@csp_nonce`: from the session on the first render, and from the browser's
  connect params on the socket (the nonce of the page that opened it), so components with
  runtime hooks (`nonce={@csp_nonce}`) carry the right one after live navigation too.
  """
  @behaviour Plug

  import Plug.Conn

  @impl true
  def init(opts), do: opts

  @impl true
  def call(conn, _opts) do
    nonce = 18 |> :crypto.strong_rand_bytes() |> Base.url_encode64(padding: false)

    conn
    |> assign(:csp_nonce, nonce)
    |> put_resp_header("content-security-policy", policy(conn, nonce))
  end

  @doc false
  def policy(conn, nonce) do
    host = conn.host
    port = conn.port
    ws = "ws://#{host}:#{port} wss://#{host}:#{port} wss://#{host}"

    Enum.join(
      [
        "default-src 'self'",
        "script-src 'self' 'nonce-#{nonce}'",
        "style-src 'self'",
        "img-src 'self' data:",
        "font-src 'self'",
        "connect-src 'self' #{ws}",
        "object-src 'none'",
        "base-uri 'self'",
        "form-action 'self'",
        "frame-ancestors 'self'"
      ],
      "; "
    )
  end

  @doc "`live_session` session function: carries the request's nonce to the LiveView."
  def session(conn), do: %{"csp_nonce" => conn.assigns[:csp_nonce]}

  @doc "`on_mount` hook assigning `@csp_nonce`."
  def on_mount(:default, _params, session, socket) do
    nonce =
      if Phoenix.LiveView.connected?(socket) do
        (Phoenix.LiveView.get_connect_params(socket) || %{})["csp_nonce"]
      else
        session["csp_nonce"]
      end

    {:cont, Phoenix.Component.assign(socket, :csp_nonce, valid(nonce))}
  end

  defp valid(nonce) when is_binary(nonce) do
    if Regex.match?(~r/\A[A-Za-z0-9_-]{1,64}\z/, nonce), do: nonce
  end

  defp valid(_), do: nil
end
