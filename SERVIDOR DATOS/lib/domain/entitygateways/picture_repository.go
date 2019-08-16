package entitygateways

import "gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entities"

// PictureRepository is the entity gateway
type PictureRepository interface {
	FindPicture(personID string) entities.Picture
}
