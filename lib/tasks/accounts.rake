namespace :accounts do
  task create: :environment do
    Account.transaction do
      [Developer, Business].each do |klass|
        klass.includes(:user).find_each do |instance|
          instance.account = Account.build_with_owner(instance.user)
          instance.save!
        end
      end
    end

    # TODO: Migrate Pay accounts/customers/payments.
  end
end
