# frozen_string_literal: true

class HealthController < ApplicationController
  def ping
    KafkaLogger.instance.log(
      event_name: 'user_signed_up',
      payload: { user_id: 'test' }
    )

    render json: { status: 'ok' }
  end
end
