#criando uma estrutura de fatores
categoriaFuncional <- c (1, 2, 2, 1, 0, 0, 1)
recodifica <- c (tecnico = 1, docente = 2 )
(categoriaFuncional <- factor(categoriaFuncional, levels = recodifica, labels = names (recodifica)))
