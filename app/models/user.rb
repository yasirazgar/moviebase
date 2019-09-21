#      Column      |              Type              | Collation | Nullable |              Default
# -----------------+--------------------------------+-----------+----------+-----------------------------------
#  id              | bigint                         |           | not null | nextval('users_id_seq'::regclass)
#  name            | character varying              |           |          |
#  email           | character varying              |           |          |
#  password_digest | character varying              |           |          |
#  created_at      | timestamp(6) without time zone |           | not null |
#  updated_at      | timestamp(6) without time zone |           | not null |
# Indexes:
#     "users_pkey" PRIMARY KEY, btree (id)

class User < ApplicationRecord
  has_secure_password

  has_many :movies
  has_many :ratings

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
