# Tool Integration for Phase 1 Confidence Scoring

## 1. Overview

This document details the design and integration of the Phase 1 tooling components for confidence scoring in the AI-Native Programming Paradigm. The focus is on the IDE Integration Layer/Gateway and the VSCode IDE extension.

## 2. IDE Integration Layer/Gateway (v1)

### 2.1. Core Responsibilities

*   **Proxying Requests:** Act as an intermediary between the IDE extension and backend services (AI Confidence Scoring Service, Metadata Store).
*   **Authentication:** Handle basic authentication for secure communication.
*   **WebSocket Management:** Manage WebSocket connections for push notifications to the IDE extension.

### 2.2. API Endpoints

*   **POST /confidence**
    *   **Description:** Receive requests from the IDE extension to calculate confidence scores.
    *   **Request Body:**
        ```json
        {
            "anrf_reference": "unique_anrf_id"
        }
        ```
    *   **Response:**
        ```json
        {
            "task_id": "unique_task_id"
        }
        ```
    *   **Status Codes:**
        *   `202 Accepted`: Request accepted, task ID returned.
        *   `400 Bad Request`: Invalid input.
        *   `401 Unauthorized`: Authentication required.
        *   `500 Internal Server Error`: Server error.

*   **WebSocket /updates**
    *   **Description:** WebSocket endpoint for the IDE extension to receive push notifications about confidence score updates.
    *   **Message Format:**
        ```json
        {
            "anrf_reference": "unique_anrf_id",
            "updated_metadata": {
                "confidence_score": 0.95,
                "confidence_type": "calibrated_probability",
                "confidence_rationale": "Confidence based on calibrated output probability distribution of the generation model."
            }
        }
        ```

### 2.3. Technology Stack

*   **Backend Framework:** Node.js with Express for handling HTTP requests and WebSocket connections.
*   **Authentication:** JWT for secure communication.
*   **Event Bus:** Redis PubSub or Kafka for event-driven notifications.
*   **Caching:** Redis for caching confidence scores to optimize performance.

## 3. IDE Extension (VSCode MVP)

### 3.1. Visual Indicators

*   **Color Coding:**
    *   **Green:** Formally verified
    *   **Blue:** High confidence (statistical guarantee)
    *   **Yellow:** Medium confidence (calibrated estimate)
    *   **Orange:** Low confidence (heuristic estimate)
    *   **Red:** Verification failed or critical concerns

*   **Icons:**
    *   **✓ (checkmark):** Formally verified
    *   **📊 (chart):** Statistical guarantee
    *   **🔄 (cycle):** Calibrated estimate
    *   **💡 (lightbulb):** Heuristic estimate
    *   **⚠️ (warning):** Needs attention

### 3.2. Hover-Over Details Panel

*   **Content:**
    *   **Confidence Score:** Numerical value
    *   **Confidence Type:** Categorical level
    *   **Rationale:** Explanation of the confidence score
    *   **Actions:** Available actions (e.g., View Details, Verify)

### 3.3. Interaction with Gateway

*   **Request:** Send confidence score calculation requests to the Gateway.
    *   **Example:**
        ```typescript
        const response = await fetch('https://gateway.example.com/confidence', {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ anrf_reference: 'unique_anrf_id' })
        });
        const data = await response.json();
        const taskId = data.task_id;
        ```

*   **WebSocket Updates:** Receive and handle WebSocket messages from the Gateway.
    *   **Example:**
        ```typescript
        const socket = new WebSocket('wss://gateway.example.com/updates');
        socket.onmessage = (event) => {
            const message = JSON.parse(event.data);
            const { anrf_reference, updated_metadata } = message;
            // Update the editor with the new confidence score
        };
        ```

## 4. Data Flow

### 4.1. WebSocket Message Format

*   **Description:** Format for messages sent from the Gateway to the IDE extension containing confidence score updates.
*   **Example:**
    ```json
    {
        "anrf_reference": "unique_anrf_id",
        "updated_metadata": {
            "confidence_score": 0.95,
            "confidence_type": "calibrated_probability",
            "confidence_rationale": "Confidence based on calibrated output probability distribution of the generation model."
        }
    }
    ```

### 4.2. Error Handling

*   **Gateway Connection Issues:** Implement retry logic and user notifications for connection issues.
*   **Metadata Update Failures:** Log errors and notify the user if updates fail.

## 5. Implementation Considerations

*   **Performance:** Ensure low latency for real-time feedback.
*   **Scalability:** Design for horizontal scaling to handle high load.
*   **Security:** Implement secure communication and authentication mechanisms.
*   **Extensibility:** Design with future enhancements in mind (e.g., additional confidence models, more detailed hover-over panels).