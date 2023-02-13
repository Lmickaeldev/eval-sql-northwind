-- 1 Liste des clients français :
SELECT CompanyName AS société , ContactName AS contact , ContactTitle AS fonction, Phone AS Telephone 
FROM `customers` 
WHERE Country = 'France'; 

-- 2 Liste des produits vendus par le fournisseur "Exotic Liquids" :
SELECT ProductName AS'Produit', UnitPrice AS'Prix' 
FROM products 
JOIN suppliers 
ON suppliers.SupplierID= products.SupplierID 
WHERE CompanyName='Exotic Liquids';

-- 3 Nombre de produits mis à disposition par les fournisseurs français (tri par nombre de produits décroissant) :
SELECT CompanyName AS Fournisseur, COUNT(UnitsOnOrder) AS Nombre_produits
FROM `suppliers` 
JOIN `products` 
ON products.SupplierID = suppliers.SupplierID 
WHERE Country = 'France' 
GROUP BY Fournisseur;

-- 4 Liste des clients français ayant passé plus de 10 commandes :
SELECT CompanyName AS Client, COUNT(OrderId) as Nbre_commandes
FROM `customers` 
JOIN `orders` 
ON orders.CustomerID = customers.CustomerID 
WHERE Country = 'France' 
GROUP BY Client 
HAVING Nbre_commandes > 10;

-- 5 Liste des clients dont le montant cumulé de toutes les commandes passées est supérieur à 30000 € :
SELECT SUM(UnitPrice * Quantity) AS 'CA' , CompanyName as 'client' 
FROM `customers` 
INNER JOIN `orders` ON orders.CustomerID = customers.CustomerID
JOIN `order details` ON `order details`.orderID = orders.OrderID 
GROUP BY Client HAVING CA > 30000;

-- 6 Liste des pays dans lesquels des produits fournis par "Exotic Liquids" ont été livrés :
SELECT ShipCountry AS pays
FROM `orders` 
JOIN `order details`
ON `order details`.`OrderID` = orders.OrderID 
JOIN `products` 
ON products.ProductID = `order details`.`ProductID`
JOIN `suppliers` 
ON suppliers.SupplierID = products.SupplierID
WHERE suppliers.CompanyName = 'Exotic Liquids' 
GROUP BY pays;

-- 7 - Chiffre d'affaires global sur les ventes de 1997 :
SELECT SUM(UnitPrice * Quantity) AS montant_Ventes_1997
FROM `order details` 
JOIN `orders` 
ON orders.OrderID = `order details`.`OrderID` 
WHERE YEAR(OrderDate) = 1997;

-- 8 - Chiffre d'affaires détaillé par mois, sur les ventes de 1997 :
SELECT MONTH(OrderDate) AS mois_97, SUM(UnitPrice * Quantity) AS montant_ventes
FROM `order details` 
JOIN `orders` 
ON orders.OrderID = `order details`.`OrderID` 
WHERE YEAR(OrderDate) = 1997 
GROUP BY MONTH(OrderDate);

-- 9 - A quand remonte la dernière commande du client nommé "Du monde entier" ?
SELECT MAX(OrderDate) AS Date_de_derniere_cmd
FROM `orders` 
JOIN `customers` 
ON customers.CustomerID = orders.CustomerID 
WHERE CompanyName = 'Du monde entier';

-- 10 - Quel est le délai moyen de livraison en jours ?
SELECT AVG(DATEDIFF(ShippedDate, OrderDate )) AS Délais_moyen_de_livraison
FROM `orders`;