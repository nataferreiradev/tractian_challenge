

# Tractian Challenge

## Comentários sobre o projeto

Meu foco foi na padronização de classes e interfaces, além da performance da interface.

Para preparar a `TreeView`, utilizei a estrutura de dados árvore.

O único problema que encontrei nos meus testes foi a filtragem por botões. Por algum motivo que não identifiquei, a filtragem só funciona na primeira vez que a tela é aberta. Nas vezes seguintes, parece que a árvore não é remontada corretamente. A filtragem pelo campo de texto parece funcionar normalmente.

Para a performance da listagem, utilizei o método conhecido como lazy loading.

## Desafios que enfrentei

Ao utilizar a árvore, precisei implementar uma solução para a filtragem. No entanto, não conheço nem consegui implementar nenhum algoritmo que filtre a árvore e mantenha os nós pais. Decidi então tentar uma abordagem que reconstrói a árvore toda vez que é filtrada, mas tive dificuldade com os nós na parte final da árvore (folhas).
