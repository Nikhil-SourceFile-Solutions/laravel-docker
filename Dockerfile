# Use official PHP 8.2 image with FPM
FROM php:8.2-fpm

# Install system tools and PHP libraries needed for Laravel
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory inside the container
WORKDIR /var/www

# Copy current folder into the container
COPY . .

# Install Laravel PHP dependencies
RUN composer install

# ✅ Start Laravel dev server instead of php-fpm
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
