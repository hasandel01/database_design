CREATE ROLE supervisor;
GRANT SELECT ON ecommercedb.* TO supervisor;
GRANT INSERT ON ecommercedb.incident TO supervisor;
CREATE USER 'clark_kent' IDENTIFIED BY 'superman' DEFAULT ROLE 'supervisor';

CREATE ROLE representative;
GRANT SELECT ON ecommercedb.* TO representative;
CREATE USER 'bob_dylan' IDENTIFIED BY 'musiclegend' DEFAULT ROLE 'representative';

FLUSH PRIVILEGES
