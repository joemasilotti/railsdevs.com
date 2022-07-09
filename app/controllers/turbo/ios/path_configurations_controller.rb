module Turbo
  module Ios
    class PathConfigurationsController < ApplicationController
      def show
        render json: {
          settings: {
            tabs: [
              {
                title: "Home",
                path: "/",
                ios_system_image_name: "house"
              },
              {
                title: "Conversations",
                path: "/conversations",
                ios_system_image_name: "envelope"
              },
              {
                title: "Notifications",
                path: "/notifications",
                ios_system_image_name: "bell"
              }
            ]
          },
          rules: [
            {
              patterns: [
                "/new$",
                "/edit$"
              ],
              properties: {
                presentation: "modal"
              }
            },
            {
              patterns: [
                "/users/sign_up"
              ],
              properties: {
                flow: "safari"
              }
            },
            {
              patterns: [
                "/users/sign_in"
              ],
              properties: {
                flow: "authentication"
              }
            }
          ]
        }
      end
    end
  end
end
