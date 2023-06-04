

#!/bin/bash
terraform graph > graph.dot
cat ./graph.dot | dot -Txvg > graph.svg