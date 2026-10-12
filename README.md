# Easy Task - Modern Task & Everyday Checklist Application

**Easy Task** is a modern, full-stack productivity web application designed for students, IT employees, working professionals, and everyday users. It streamlines scheduling, priority tracking, advance deadline reminders, and everyday shopping/grocery checklists in a single interface inspired by Todoist and Microsoft To Do.

---

## 1. Features Overview

- **Dashboard**:
  - Live metric cards: Total, Pending, Completed, Overdue, Today's, Upcoming, and High-Priority tasks.
  - Interactive task completion rate percentage and visual progress bar.
  - Quick-Add task bar for instant scheduling.
  - Priority alert banner for overdue items.
  - Preview lists for today's tasks and upcoming deadlines.
- **Task Management**:
  - Full CRUD: Add, Edit, Delete (with confirmation dialog), Complete, and Reopen tasks.
  - Search by task title or description in real time.
  - Filter by Status (`ALL`, `PENDING`, `IN_PROGRESS`, `COMPLETED`, `OVERDUE`), Priority (`HIGH`, `MEDIUM`, `LOW`), and Category (`Work`, `Study`, `Personal`, `Health`, `Finance`, etc.).
  - Sort by Due Date, Creation Date, or Priority.
- **Dedicated Task Views**:
  - **Today's Tasks**: Focused daily view with status breakdown badges.
  - **Upcoming Tasks**: Future schedule sorted chronologically.
  - **Completed Tasks**: History of accomplishments with completion timestamps.
- **Everyday Checklists & Groceries**:
  - Create multiple custom checklists (e.g., *Weekly Groceries*, *Household Supplies*, *Shopping List*).
  - Add items with quantities, units, and categories.
  - Check/uncheck items with real-time percentage progress bar.
  - Accent color picker for each checklist.
- **Advance Reminder & Notification System**:
  - Backend Spring scheduler (`@EnableScheduling`) runs every 30 seconds to monitor upcoming deadlines.
  - Advance reminder intervals: 5 minutes, 15 minutes, 30 minutes, 1 hour before, or custom datetime.
  - In-app notification bell with unread badge counter, alert icons, and "Mark all read" action.
  - Browser Desktop Notification integration (`Notification API`) with permission toggle and instant test trigger in Settings.
  - Anti-duplication mechanism: reminders and overdue notifications are flagged to avoid repetitive alerts.
- **Settings & Preferences**:
  - User profile customization.
  - Notification permission manager & browser test button.
  - Default reminder preference selector.
  - Live backend REST API & database connectivity indicator.

---

## 2. Technology Stack

| Layer | Technologies |
| :--- | :--- |
| **Frontend** | React 18, JavaScript, Vite 5, React Router 6, Axios, Lucide React, HTML5, Modern CSS3 |
| **Backend** | Java 21 / OpenJDK, Spring Boot 3.3.4, Spring Web, Spring Data JPA, Spring Validation, Maven Wrapper |
| **Database** | MySQL 8.0+ (Primary) / H2 File-Persistence (Zero-config local fallback) |
| **Ports** | Backend: `8088` (avoids Windows Oracle TNS conflict on 8080) \| Frontend: `5173` |

---

## 3. Project Structure

```text
easy-task/
├── backend/
│   ├── src/main/java/com/easytask/
│   │   ├── config/             # CORS (WebConfig), DataInitializer
│   │   ├── controller/         # TaskController, DashboardController, GroceryController, NotificationController
│   │   ├── dto/                # TaskRequest, TaskResponse, DashboardSummaryResponse, GroceryDTOs
│   │   ├── entity/             # Task, GroceryList, GroceryItem, Notification, Enums
│   │   ├── exception/          # GlobalExceptionHandler, ResourceNotFoundException, BadRequestException
│   │   ├── repository/         # TaskRepository, GroceryListRepository, GroceryItemRepository, NotificationRepository
│   │   ├── service/            # TaskService, GroceryService, NotificationService, ReminderSchedulerService
│   │   └── EasyTaskApplication.java
│   ├── src/main/resources/
│   │   ├── application.properties    # Primary MySQL config (server.port=8088)
│   │   ├── application-h2.properties # H2 File persistence profile
│   │   └── schema.sql                # Manual SQL creation script
│   ├── pom.xml
│   └── mvnw.cmd / mvnw
├── frontend/
│   ├── src/
│   │   ├── components/         # Navbar, Sidebar, TaskCard, TaskModal, DeleteConfirmModal, QuickAddTask, Toast
│   │   ├── layouts/            # MainLayout
│   │   ├── pages/              # DashboardPage, AllTasksPage, TodayTasksPage, UpcomingTasksPage, CompletedTasksPage, GroceryPage, SettingsPage
│   │   ├── services/           # api.js (Axios client)
│   │   ├── App.jsx
│   │   ├── main.jsx
│   │   └── index.css           # Modern design system
│   ├── .env                    # VITE_API_BASE_URL=http://localhost:8088/api
│   ├── vite.config.js
│   └── package.json
├── start-all.bat               # One-click Windows CMD launcher
├── start-all.ps1               # One-click Windows PowerShell launcher
└── README.md
```

---

## 4. Beginner Step-by-Step Execution Guide

### Prerequisites Verification

Open PowerShell or Command Prompt and verify:
```powershell
# 1. Check Node.js and npm
node -v
npm.cmd -v

# 2. Check Java (JDK 21 or compatible OpenJDK)
java -version
```

---

### Step 1: Database Setup (MySQL)

By default, the application is configured to connect to MySQL on `localhost:3306`.

1. Open your MySQL Command Line Client or MySQL Workbench.
2. Run the following command to create the database:
   ```sql
   CREATE DATABASE IF NOT EXISTS easy_task_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```
3. In `easy-task/backend/src/main/resources/application.properties`, configure your MySQL username and password (or set environment variables):
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/easy_task_db?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
   spring.datasource.username=root
   spring.datasource.password=YOUR_MYSQL_PASSWORD
   ```

> **Note on Zero-Config Fallback:** If your MySQL server is currently not configured or password protected, you can run the backend with the built-in H2 file-persistence profile (`--spring.profiles.active=h2`). It persists all your data into `./data/easytaskdb` without requiring any MySQL credentials!

---

### Step 2: Start the Spring Boot Backend

Open a terminal in `easy-task/backend`:

**Using Windows PowerShell:**
```powershell
cd c:\Users\sushanthsagar\OneDrive\Desktop\tt-1\easy-task\backend
.\mvnw.cmd spring-boot:run
```

*Or to run with the packaged JAR directly:*
```powershell
java -jar target\easy-task-backend-1.0.0.jar
```

*Or with H2 fallback:*
```powershell
java "-Dspring.profiles.active=h2" -jar target\easy-task-backend-1.0.0.jar
```

You should see:
```text
Tomcat started on port 8088 (http) with context path '/'
Started EasyTaskApplication in ... seconds
```

---

### Step 3: Start the React Frontend

Open a **separate** terminal window in `easy-task/frontend`:

**Using PowerShell:**
```powershell
cd c:\Users\sushanthsagar\OneDrive\Desktop\tt-1\easy-task\frontend
npm.cmd run dev
```

You should see:
```text
  VITE v5.4.x  ready in ... ms

  ➜  Local:   http://localhost:5173/
```

---

### Step 4: Open in Your Browser

Open your browser and navigate to:
**[http://localhost:5173](http://localhost:5173)**

The frontend will automatically communicate with the backend on `http://localhost:8088`.

---

## 5. One-Click Launchers

For convenience, you can simply double-click either:
- **`start-all.bat`**: Launches both Backend and Frontend in separate windows automatically.
- Or in PowerShell run: `.\start-all.ps1`.

---

## 6. REST API Endpoints Reference

### Tasks (`/api/tasks`)
- `GET /api/tasks` — Retrieve all tasks (supports query params `status`, `priority`, `category`, `search`, `sortBy`, `sortDir`)
- `POST /api/tasks` — Create a new task
- `GET /api/tasks/{id}` — Get single task
- `PUT /api/tasks/{id}` — Update task
- `DELETE /api/tasks/{id}` — Delete task
- `PATCH /api/tasks/{id}/complete` — Mark task as COMPLETED
- `PATCH /api/tasks/{id}/reopen` — Reopen completed task as PENDING
- `GET /api/tasks/today` — Tasks due today
- `GET /api/tasks/upcoming` — Tasks due in future
- `GET /api/tasks/completed` — All completed tasks
- `GET /api/tasks/overdue` — All overdue tasks

### Dashboard (`/api/dashboard`)
- `GET /api/dashboard/summary` — Full statistics overview (total, pending, completed, overdue, today, upcoming, high priority, completion rate, task lists)

### Everyday Checklists (`/api/grocery-lists`)
- `GET /api/grocery-lists` — Get all checklists with item counts
- `POST /api/grocery-lists` — Create new checklist
- `PUT /api/grocery-lists/{id}` — Edit checklist title/description/color
- `DELETE /api/grocery-lists/{id}` — Delete checklist
- `POST /api/grocery-lists/{listId}/items` — Add item to checklist
- `PATCH /api/grocery-lists/items/{itemId}/toggle` — Check/uncheck item purchased
- `DELETE /api/grocery-lists/items/{itemId}` — Remove item

### Notifications (`/api/notifications`)
- `GET /api/notifications` — Retrieve notifications
- `GET /api/notifications/unread-count` — Count of unread notifications
- `PATCH /api/notifications/{id}/read` — Mark notification read
- `PATCH /api/notifications/read-all` — Mark all notifications read

---

## 7. Troubleshooting Guide

### 1. `Port 8080 was already in use`
- **Cause**: On many Windows machines, Oracle Database Listener (`TNSLSNR`) or IIS runs on port 8080.
- **Solution**: Easy Task is pre-configured to use **Port 8088** in `application.properties` and `vite.config.js`. If you need to change it further, set `SERVER_PORT=8090` in your environment or properties.

### 2. `npm.ps1 cannot be loaded because running scripts is disabled`
- **Cause**: Windows PowerShell execution policy restriction.
- **Solution**: Use `npm.cmd` instead of `npm` in PowerShell (e.g., `npm.cmd run dev`, `npm.cmd install`), or run `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`.

### 3. `Access denied for user 'root'@'localhost'` (MySQL Error 1045)
- **Cause**: Your local MySQL root password differs from the default `root`.
- **Solution**:
  - Edit `easy-task/backend/src/main/resources/application.properties` and replace `spring.datasource.password=root` with your actual MySQL password.
  - Or run the backend with the H2 profile (`java "-Dspring.profiles.active=h2" -jar target\easy-task-backend-1.0.0.jar`) for instant file-based persistence without needing MySQL credentials.

### 4. Browser Notifications Not Popping Up
- **Cause**: Browser permissions are currently set to "Ask" or "Block".
- **Solution**:
  - Navigate to the **Settings** page in Easy Task and click **"Enable"** on the Browser Notifications card.
  - Click **"Allow"** on the browser prompt.
  - Click **"Send Test Desktop Notification"** to confirm the popup appears in your Windows action center.
