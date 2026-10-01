--liquibase formatted sql

--changeset umg:005-seed-roles
INSERT INTO roles (id, name, description) VALUES
('r001', 'ROLE_ADMIN', 'Administrador general con acceso total'),
('r002', 'ROLE_VENTAS', 'Usuario de ventas y consultas con acceso limitado')
ON CONFLICT (id) DO NOTHING;

--changeset umg:005-seed-users
-- Contraseñas hasheadas con BCrypt (costo 10):
-- admin123 -> $2a$10$e2tNd0b885lVcUIWC3QTl.ck7t4kMMlQXnVXFhehqUsBEhIizFDg.
-- user123  -> $2a$10$5GYZdeiD/OtDg.eqfC/2aeN5Z67ZPh1HHLh7HyULlCwljLpWyILLW
INSERT INTO users (id, full_name, email, password, is_active, created_at) VALUES
('u001', 'Kelvin Castillo', 'admin@empresa.com', '$2a$10$e2tNd0b885lVcUIWC3QTl.ck7t4kMMlQXnVXFhehqUsBEhIizFDg.', true, CURRENT_TIMESTAMP),
('u002', 'Operador Ventas', 'user@empresa.com', '$2a$10$5GYZdeiD/OtDg.eqfC/2aeN5Z67ZPh1HHLh7HyULlCwljLpWyILLW', true, CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

--changeset umg:005-seed-user-roles
INSERT INTO user_roles (user_id, role_id) VALUES
('u001', 'r001'),
('u002', 'r002')
ON CONFLICT (user_id, role_id) DO NOTHING;

--changeset umg:005-seed-categories
INSERT INTO categories (id, name, description, is_active) VALUES
('cat001', 'Herramientas Eléctricas', 'Taladros, esmeriles, sierras y pulidoras', true),
('cat002', 'Herramientas Manuales', 'Martillos, destornilladores, llaves y pinzas', true),
('cat003', 'Pinturas & Acabados', 'Pinturas látex, anticorrosivos y brochas', true),
('cat004', 'Plomería & Tuberías', 'Tubos PVC, accesorios, grifería y pegamentos', true),
('cat005', 'Material Eléctrico', 'Cables THHN, tomacorrientes y breakers', true)
ON CONFLICT (id) DO NOTHING;

--changeset umg:005-seed-products
INSERT INTO products (id, name, sku, category_id, selling_price, cost_price, stock, min_stock, unit, description, image_url, is_active, created_at) VALUES
('p001', 'Taladro Inalámbrico 20V DeWalt', 'TAL-DW-20V', 'cat001', 145.00, 110.00, 18, 5, 'Unidad', 'Taladro percutor con 2 baterías de litio y maletín.', 'https://images.unsplash.com/photo-1504148455328-c376907d081c?auto=format&fit=crop&w=800&q=80', true, CURRENT_TIMESTAMP),
('p002', 'Juego de Destornilladores Stanley (10 pzs)', 'DES-ST-10P', 'cat002', 24.50, 16.00, 35, 10, 'Juego', 'Destornilladores planos y phillips con mango ergonómico.', 'https://images.unsplash.com/photo-1581147036324-c17ac41dfa6c?auto=format&fit=crop&w=800&q=80', true, CURRENT_TIMESTAMP),
('p003', 'Pintura Látex Blanca Cubeta 5 Gal', 'PIN-LT-5GL', 'cat003', 68.00, 48.00, 22, 6, 'Cubeta', 'Pintura antihongos de alto cubrimiento lavable.', 'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?auto=format&fit=crop&w=800&q=80', true, CURRENT_TIMESTAMP),
('p004', 'Tubo PVC Presión 1/2 pulgada (6m)', 'TUB-PVC-05', 'cat004', 6.25, 4.10, 80, 20, 'Tubo', 'Tubo PVC cédula 40 para conducción de agua potable.', 'https://images.unsplash.com/photo-1542013936693-884638332954?auto=format&fit=crop&w=800&q=80', true, CURRENT_TIMESTAMP),
('p005', 'Cable Eléctrico THHN Calibre 12 (100m)', 'CAB-TH-12C', 'cat005', 89.90, 68.00, 12, 4, 'Rollo', 'Conductor de cobre puro resistente a alta temperatura.', 'https://images.unsplash.com/photo-1544724569-5f546fd6f2b5?auto=format&fit=crop&w=800&q=80', true, CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

--changeset umg:005-seed-clients
INSERT INTO clients (id, full_name, email, phone, address, nit, is_active, created_at) VALUES
('c001', 'Carlos Morales Fuentes', 'carlos.morales@gmail.com', '5534-2210', 'Zona 1, Ciudad de Guatemala', '1234567-8', true, CURRENT_TIMESTAMP),
('c002', 'Marta Elena López', 'marta.lopez@outlook.com', '4422-9901', 'Zona 7, Mixco', '9876543-2', true, CURRENT_TIMESTAMP),
('c003', 'Constructora Los Álamos S.A.', 'info@losalamos.com', '2200-4455', 'Carretera a El Salvador km 14.5', '3344556-7', true, CURRENT_TIMESTAMP),
('c004', 'Roberto Ajú Ajú', 'roberto.aju@yahoo.com', '5678-3311', 'Zona 18, Guatemala', '7788990-1', false, CURRENT_TIMESTAMP),
('c005', 'Ferretería El Tornillo', 'compras@eltornillo.gt', '2266-8800', 'Zona 3, Quetzaltenango', '5566778-0', true, CURRENT_TIMESTAMP),
('c006', 'Ana Patricia Morán', 'ana.moran@empresa.com', '4411-7722', 'Zona 10, Guatemala', '1122334-5', true, CURRENT_TIMESTAMP),
('c007', 'Distribuidora Centrocom', 'ventas@centrocom.gt', '2277-5533', 'Calzada Aguilar Batres 42-10', '6677889-0', true, CURRENT_TIMESTAMP),
('c008', 'José Miguel Recinos', 'jose.recinos@gmail.com', '5599-1234', 'San José Pinula, Guatemala', '4455667-8', false, CURRENT_TIMESTAMP),
('c009', 'Proyectos y Obras GT', 'contacto@pyogt.com', '2288-4400', 'Zona 4, Guatemala', '8899001-2', true, CURRENT_TIMESTAMP),
('c010', 'Luisa Fernanda Chávez', 'luisa.chavez@hotmail.com', '5577-9988', 'Zona 11, Guatemala', '3322110-9', true, CURRENT_TIMESTAMP),
('c011', 'Inversiones del Norte S.A.', 'administracion@idelnorte.gt', '2244-6688', 'Santa Cruz del Quiché', '7766554-3', true, CURRENT_TIMESTAMP),
('c012', 'Pedro Pablo Tzoc', 'pedro.tzoc@gmail.com', '4433-5566', 'Chimaltenango, Guatemala', '5544332-1', false, CURRENT_TIMESTAMP),
('c013', 'Grupo Constructor Altavista', 'proyectos@altavista.com', '2255-3311', 'Zona 16, Guatemala', '9988776-5', true, CURRENT_TIMESTAMP),
('c014', 'Silvia Beatriz Alvarado', 'silvia.alvarado@yahoo.com', '5566-4422', 'Villa Nueva, Guatemala', '2211009-8', true, CURRENT_TIMESTAMP),
('c015', 'Materiales y Acabados Express', 'ventas@macexpress.gt', '2299-7755', 'Zona 12, Guatemala', '6655443-2', true, CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

--changeset umg:005-seed-suppliers
INSERT INTO suppliers (id, company_name, contact_name, email, phone, address, nit, is_active, created_at) VALUES
('sup001', 'DeWalt Herramientas Centroamérica', 'Ing. Roberto Méndez', 'contacto@dewalt-ca.com', '2300-1122', 'Parque Industrial Las Américas', '1199887-4', true, CURRENT_TIMESTAMP),
('sup002', 'Pinturas Corona de Guatemala', 'Licda. Carolina Soto', 'pedidos@coronagt.com', '2410-5566', 'Km 18.5 Carretera al Atlántico', '4433221-9', true, CURRENT_TIMESTAMP),
('sup003', 'Tuberías y Plásticos del Sur S.A.', 'Mario Enrique Solís', 'ventas@tuboplast.gt', '2240-8899', 'Zona 12, Ciudad de Guatemala', '8877665-1', true, CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;
