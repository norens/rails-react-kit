import { useEffect, useState } from "react";
import { getHello } from "./api/api.ts";

export default function Ping() {
	const [message, setMessage] = useState("Loading...");

	useEffect(() => {
		getHello()
			.then(setMessage)
			.catch(() => setMessage("Error connecting to backend"));
	}, []);

	return (
		<div>
			<h1>Backend says:</h1>
			<p>{message}</p>
		</div>
	);
}