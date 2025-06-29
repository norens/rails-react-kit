import { ENV } from "../config/env";

export async function getHello(): Promise<string> {
	const response = await fetch(`${ENV.API_URL}/api/hello`);
	if (!response.ok) {
		throw new Error("Failed to fetch /api/hello");
	}
	const data = await response.json();
	return data.message;
}