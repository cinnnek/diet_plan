document.addEventListener('DOMContentLoaded', () => {
        const searchInput = document.getElementById('searchInput');
        const productTable = document.getElementById('productTable');
        const rows = productTable.getElementsByTagName('tr');

        searchInput.addEventListener('input', () => {
            const filter = searchInput.value.toLowerCase();

            for (const row of rows) {
                const cells = row.getElementsByTagName('td');
                let match = false;

                for (const cell of cells) {
                    if (cell.textContent.toLowerCase().includes(filter)) {
                        match = true;
                        break;
                    }
                }

                row.style.display = match ? '' : 'none';
            }
        });
    });