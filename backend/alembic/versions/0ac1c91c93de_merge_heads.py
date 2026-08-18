"""merge heads

Revision ID: 0ac1c91c93de
Revises: 3643a8308bc1, ebc1ca2cb9a8
Create Date: 2026-08-18 14:32:36.043909

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '0ac1c91c93de'
down_revision: Union[str, Sequence[str], None] = ('3643a8308bc1', 'ebc1ca2cb9a8')
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
