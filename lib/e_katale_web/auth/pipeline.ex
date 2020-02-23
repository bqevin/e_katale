defmodule EKataleWeb.Auth.Pipeline do
    use Guardian.Plug.Pipeline, otp_app: :e_katale,
    module: EKataleWeb.Auth.Guardian,
    error_handler: EKataleWeb.Auth.ErrorHandler

    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
end