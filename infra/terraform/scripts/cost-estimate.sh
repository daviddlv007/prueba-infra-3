#!/bin/bash
set -e

ENVIRONMENT=${1:-dev}
cd ./infra/terraform/environments/$ENVIRONMENT

# Estimación básica de costos para recursos comunes
echo "=== COST ESTIMATION FOR $ENVIRONMENT ==="

# EC2 Instance
echo "EC2 t2.micro: ~\$9.50/month (730 hours)"

# EBS Volume  
echo "EBS gp3 8GB: ~\$0.80/month"

# S3 Storage (estimado para estado Terraform)
echo "S3 Storage (1GB): ~\$0.023/month"

# DynamoDB (estimado para locking)
echo "DynamoDB: ~\$0.25/month"

# Data Transfer (estimado)
echo "Data Transfer (10GB): ~\$0.90/month"

echo "----------------------------------------"
echo "TOTAL ESTIMATED: ~\$11.47/month"
echo "FREE TIER: Covers most resources for first 12 months"