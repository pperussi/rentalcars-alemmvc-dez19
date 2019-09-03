class AddAddressableToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :addressabble, polymorphic: true
  end
end
