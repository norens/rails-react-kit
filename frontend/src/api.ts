const API_URL = import.meta.env.VITE_API_URL;

export async function getHello(): Promise<string>
{
	const res = await fetch(`${API_URL}/api/hello`);
	if (!res.ok) throw new Error("Failed to fetch");
	const data = await res.json();
	return data.message;
}