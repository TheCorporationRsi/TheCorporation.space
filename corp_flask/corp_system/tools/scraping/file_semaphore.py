

import os
import time

class FileSemaphore:
    def __init__(self, filepath):
        self.filepath = filepath

    def acquire(self, timeout=60):
        """Attempt to acquire the semaphore within a timeout period."""
        start_time = time.time()
        acquired = False
        was_locked = False
        while (time.time() - start_time) < timeout:
            try:
                # Attempt to create the file in an atomic operation to avoid race conditions
                with os.fdopen(os.open(self.filepath, os.O_CREAT | os.O_EXCL | os.O_WRONLY), 'w') as f:
                    f.write("Locked")
                acquired = True
                if was_locked:
                    time.sleep(1)
                break
            except FileExistsError:
                # File already exists, semaphore is locked, wait and retry
                was_locked = True
                time.sleep(1)
        return acquired

    def release(self):
        """Release the semaphore by deleting the file."""
        try:
            os.remove(self.filepath)
        except FileNotFoundError:
            pass  # File was already deleted, semaphore is unlocked

if __name__ == "__main__":
 
    # Example usage
    semaphore_file = "/tmp/rsi_request.lock"
    semaphore = FileSemaphore(semaphore_file)

    if semaphore.acquire():
        try:
            print("Semaphore acquired, accessing shared resource...")
            # Access shared resource here
            time.sleep(2)  # Simulate work
        finally:
            semaphore.release()
            print("Semaphore released.")
    else:
        print("Failed to acquire semaphore within timeout.")