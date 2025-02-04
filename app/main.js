exports.handler = async () => {
    return {
        statusCode: 200,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify([
            { name: "John Doe", email: "john@example.com" },
            { name: "Jane Smith", email: "jane@example.com" }
        ])
    };
};