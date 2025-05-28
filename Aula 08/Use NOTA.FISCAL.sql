SELECT * FROM nota_fiscal_normalizada.nota_fiscal;

USE nota_fiscal_normalizada;

CREATE FUNCTION hello(s CHAR(20))
	RETURNS CHAR(50) DETERMINISTIC 
    RETURN CONCAT('Olá, ', s, '!') 
    
SELECT Hello('Silvio');

select Hello ( DESC_PRODUTO ) 
from produto
WHERE COD_PRODUTO = 1;

