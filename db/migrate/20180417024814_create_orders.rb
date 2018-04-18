Sequel.migration do
  change do

    run('CREATE EXTENSION IF NOT EXISTS "uuid-ossp"')

    create_table :orders do
      primary_key :id
      uuid :uuid, default: Sequel.function(:uuid_generate_v4)
    end
  end
end
