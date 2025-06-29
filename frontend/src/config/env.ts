function getEnv(name: string): string
{
	const value = import.meta.env[name];
	if (!value) {
		throw new Error(`Missing environment variable: ${name}`);
	}
	return value;
}

export const ENV = {
	API_URL: getEnv("VITE_API_URL")
};
