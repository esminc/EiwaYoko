class TokenPair < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  def update_token!(object)
    self.update_attributes(
      :refresh_token => object.refresh_token,
      :access_token  => object.access_token,
      :expires_in    => object.expires_in,
      :issued_at     => object.issued_at
    )
  end

  def to_hash
    return {
      :refresh_token => self.refresh_token,
      :access_token  => self.access_token,
      :expires_in    => self.expires_in,
      :issued_at     => Time.at(self.issued_at)
    }
  end
end
