package entitygateways

import "gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entities"

// UserRepository is the entity gateway
type UserRepository interface {
	FindUser(username string) entities.User
}
